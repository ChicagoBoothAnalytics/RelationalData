from copy import copy
from numpy import allclose, array, float32
from sympy import Atom, Float, Integer
from sympy.core.numbers import NegativeOne, One, Zero
from sympy.matrices import Matrix


FLOAT_TYPES = float, Float, float32, Integer, NegativeOne, One, Zero, Matrix


def is_non_atomic_sympy_expr(obj):
    return hasattr(obj, 'doit') and not isinstance(obj, Atom)


def sympy_to_float(sympy_number_or_matrix):
    if isinstance(sympy_number_or_matrix, FLOAT_TYPES):
        return float(sympy_number_or_matrix)
    else:
        return array(sympy_number_or_matrix.tolist(), dtype=float)


def sympy_allclose(*sympy_matrices, **kwargs):
    if len(sympy_matrices) == 2:
        return allclose(sympy_to_float(sympy_matrices[0]), sympy_to_float(sympy_matrices[1]), **kwargs)
    else:
        for i in range(1, len(sympy_matrices)):
            if not sympy_allclose(sympy_matrices[0], sympy_matrices[i], **kwargs):
                return False
        return True


def sympy_xreplace(obj, xreplace___dict={}):
    if hasattr(obj, 'xreplace'):
        return obj.xreplace(xreplace___dict)
    elif isinstance(obj, tuple):
        return tuple(sympy_xreplace(item, xreplace___dict) for item in obj)
    elif isinstance(obj, list):
        return [sympy_xreplace(item, xreplace___dict) for item in obj]
    elif isinstance(obj, set):
        return set(sympy_xreplace(item, xreplace___dict) for item in obj)
    elif isinstance(obj, frozenset):
        return frozenset(sympy_xreplace(item, xreplace___dict) for item in obj)
    elif hasattr(obj, 'keys'):
        obj = obj.copy()
        for k, v in obj.items():
            obj[k] = sympy_xreplace(v, xreplace___dict)
        return obj
    else:
        return copy(obj)
