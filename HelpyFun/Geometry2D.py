from math import atan2, cos, sin


def euclidean_distance(x0, y0, x1=0., y1=0., squared=False):
    """EUCLIDEAN DISTANCE

    Euclidean distance between (x0, y0) and (x1, y1)
    """
    d_squared = (x1 - x0) ** 2 + (y1 - y0) ** 2
    if squared:
        return d_squared
    else:
        return d_squared ** .5


def euclidean_distance_gradients(x0, y0, x1, y1):
    """EUCLIDEAN DISTANCE GRADIENTS

    Gradients of Euclidean distance between (x0, y0) and (x1, y1) w.r.t. x0, y0, x1 and y1
    """
    dx = x1 - x0
    dy = y1 - y0
    d = euclidean_distance(dx, dy)
    return - dx / d, - dy / d, dx / d, dy / d


def manhattan_distance(x0, y0, x1=0., y1=0.):
    return abs(x1 - x0) + abs(y1 - y0)


def ray_angle(x0, y0, x1, y1):
    """RELATIVE ANGLE

    Angle from positive x-axis ("true East") to the ray from (x0, y0) to (x1, y1)
    """
    return atan2(y1 - y0, x1 - x0)


def ray_angle_gradients(x0, y0, x1, y1):
    """RELATIVE ANGLE GRADIENTS

    Gradients of the angle from positive x-axis ("true East") to the ray from (x0, y0) to (x1, y1),
    w.r.t. x0, y0, x1 and y1
    """
    dx = x1 - x0
    dy = y1 - y0
    d_squared = euclidean_distance(dx, dy, squared=True)
    return dy / d_squared, - dx / d_squared, - dy / d_squared, dx / d_squared


def angular_difference(from_angle, to_angle):
    """ANGULAR DIFFERENCE

    Angle between two rays at angle FROM_ANGLE and angle TO_ANGLE
    """
    a = to_angle - from_angle
    return atan2(sin(a), cos(a))
