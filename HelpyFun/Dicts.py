def combine_dict_and_kwargs(dict_obj, kwargs):
    d = kwargs
    if dict_obj:
        d.update(dict_obj)
    return d


def merge_dicts_ignoring_dup_keys_and_none_values(d0, d1):
    d = d0.copy()
    for k, v in d1.items():
        if (k not in d0) or (v is not None):
            d[k] = v
    return d
