IMAGE_INSTALL:append:s32g = " xen-examples-default"

EXTRA_USERS_PARAMS:prepend:s32g = " groupadd docker; \
                                  "
