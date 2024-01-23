import pyotp

def get_totp(secret: str):
    """Returns the current TOTP code for the given secret.

    | =Arguments= | =Description= |
    | secret | The secret to generate the TOTP code for. |
    """
    totp = pyotp.TOTP(secret)
    return totp.now()