class ServiceError extends Error {
    status_code!: number
}
class UserError extends ServiceError {
    status_code: number = 400
}
class UnauthorizedError extends ServiceError {
    status_code: number = 401
}
class SystemError extends ServiceError {
    status_code: number = 500
}

export { UserError, UnauthorizedError, SystemError }