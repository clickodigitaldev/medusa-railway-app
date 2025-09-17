const { initialize } = require("@medusajs/framework")

const main = async () => {
  const { container } = await initialize()
  const apiKeyService = container.resolve("apiKeyService")
  const keys = await apiKeyService.list({ type: "publishable" })
  console.log("Publishable API Keys:")
  keys.forEach(key => {
    console.log(`Token: ${key.token}`)
  })
  process.exit(0)
}

main().catch(console.error)
