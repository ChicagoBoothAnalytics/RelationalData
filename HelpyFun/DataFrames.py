from __future__ import division
from collections import OrderedDict


def eval_from_data_frame(expression, data_frame):
    return eval(expression, dict(data_frame))


def normalize_df_sub_mu_div_sigma(data_frame, means=None, standard_deviations=None):
    if means is None:
        means = data_frame.mean()
    if standard_deviations is None:
        standard_deviations = data_frame.std()
    normalized_data_frame = (data_frame - means) / standard_deviations
    return OrderedDict(means=means, standard_deviations=standard_deviations,
                       normalized_data_frame=normalized_data_frame)
