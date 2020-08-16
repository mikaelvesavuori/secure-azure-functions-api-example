import { Context, HttpRequest } from '@azure/functions';

/**
 * @description The handler for the "securedFunction" function
 * @param {Object} context - Context object
 * @param {Object} req - Incoming HTTP request
 */
export async function securedFunction(context: Context, req: HttpRequest): Promise<void> {
  context.res = {
    status: 200,
    body: 'Heya!'
  };
}
