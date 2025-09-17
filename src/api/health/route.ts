import { MedusaRequest, MedusaResponse } from "@medusajs/framework/http"

export const GET = (
  req: MedusaRequest,
  res: MedusaResponse
) => {
  res.json({
    status: "ok",
    message: "Medusa server is running"
  })
}
