################################################################################
#
# python-streaming-form-data
#
################################################################################

PYTHON_STREAMING_FORM_DATA_VERSION = 1.13.0
PYTHON_STREAMING_FORM_DATA_SOURCE = streaming-form-data-$(PYTHON_STREAMING_FORM_DATA_VERSION).tar.gz
PYTHON_STREAMING_FORM_DATA_SITE = https://files.pythonhosted.org/packages/9e/56/bb2e447219204feaa2940a815811f95d1b21ae7d2c5424a6566f2f3a7510
PYTHON_STREAMING_FORM_DATA_SETUP_TYPE = setuptools

$(eval $(python-package))
