from copy import deepcopy
from frozendict import frozendict
from MathDict import MathDict
from numpy import zeros
from sympy.matrices import MatrixSymbol
from SymPy import is_non_atomic_sympy_expr


def within_range(x, a, b, strict=True):
    if strict:
        return (x > min(a, b)) & (x < max(a, b))
    else:
        return (x >= min(a, b)) & (x <= max(a, b))


def approx_gradients(function, argument_array, epsilon=1e-6):
    g = zeros(argument_array.shape)
    for i in range(argument_array.size):
        a_plus = argument_array.copy()
        a_plus.flat[i] += epsilon
        a_minus = argument_array.copy()
        a_minus.flat[i] -= epsilon
        g.flat[i] = (function(a_plus) - function(a_minus)) / (2 * epsilon)
    return g


def shift_time_subscripts(obj, t, *matrix_symbols_to_shift):
    if isinstance(obj, MathDict):
        return MathDict({shift_time_subscripts(key, t): shift_time_subscripts(value, t)
                           for key, value in obj.items()})
    elif isinstance(obj, frozendict):
        return frozendict({shift_time_subscripts(key, t): shift_time_subscripts(value, t)
                           for key, value in obj.items()})
    elif isinstance(obj, tuple):
        if len(obj) == 2 and not(isinstance(obj[0], (int, float))) and isinstance(obj[1], int):
            return shift_time_subscripts(obj[0], t), obj[1] + t
        else:
            return tuple(shift_time_subscripts(item, t) for item in obj)
    elif isinstance(obj, list):
        return [shift_time_subscripts(item, t) for item in obj]
    elif isinstance(obj, set):
        return {shift_time_subscripts(item, t) for item in obj}
    elif isinstance(obj, dict):
        return {shift_time_subscripts(key, t): shift_time_subscripts(value, t) for key, value in obj.items()}
    elif isinstance(obj, MatrixSymbol):
        args = obj.args
        if isinstance(args[0], tuple):
            return MatrixSymbol(shift_time_subscripts(args[0], t), args[1], args[2])
        else:
            return deepcopy(obj)
    elif is_non_atomic_sympy_expr(obj):
        return obj.xreplace({matrix_symbol: shift_time_subscripts(matrix_symbol, t)
                             for matrix_symbol in matrix_symbols_to_shift})
    else:
        return deepcopy(obj)
