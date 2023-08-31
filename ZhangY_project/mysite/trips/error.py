class InternalError(Exception):
    def __init__(self, code, message):
        self.code = code
        self.message = message
        super().__init__(self.message)


OK = 200
UNAUTHORIZED = 10001

error_str = {
    OK: 'Success',
    UNAUTHORIZED: 'Please put the token in the header'
}
