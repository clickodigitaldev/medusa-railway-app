# Medusa Railway Deployment Guide

This guide will help you deploy your Medusa application to Railway with PostgreSQL and Redis.

## Prerequisites

1. Railway account (you're already logged in)
2. This repository pushed to GitHub

## Step 1: Create Railway Project

1. Go to [Railway Dashboard](https://railway.app/dashboard)
2. Click "New Project"
3. Select "Deploy from GitHub repo"
4. Connect your GitHub account if not already connected
5. Select this repository

## Step 2: Add Services

### Add PostgreSQL Database
1. In your Railway project, click "New Service"
2. Select "Database" → "PostgreSQL"
3. Railway will automatically create a PostgreSQL instance

### Add Redis
1. Click "New Service" again
2. Select "Database" → "Redis"
3. Railway will automatically create a Redis instance

## Step 3: Configure Environment Variables

In your Railway project dashboard, go to your Medusa service and add these environment variables:

### Required Variables:
- `DATABASE_URL`: Use the PostgreSQL connection string from Railway
- `REDIS_URL`: Use the Redis connection string from Railway
- `JWT_SECRET`: Generate a secure random string
- `COOKIE_SECRET`: Generate a secure random string
- `NODE_ENV`: Set to `production`
- `MEDUSA_ADMIN_ONBOARDING_TYPE`: Set to `default`

### CORS Variables (adjust domains as needed):
- `STORE_CORS`: Your storefront domain (e.g., `https://your-store.com`)
- `ADMIN_CORS`: Your Railway app domain + port 9000
- `AUTH_CORS`: Combination of store and admin domains

### Worker Configuration:
- `MEDUSA_WORKER_MODE`: Set to `server` for main instance

## Step 4: Deploy Server Mode

1. Your main service should deploy automatically
2. Railway will build using the Dockerfile
3. The application will be available on the generated Railway domain

## Step 5: Deploy Worker Mode (Optional)

For better performance, deploy a separate worker instance:

1. Create another service from the same GitHub repo
2. Set the same environment variables
3. Change `MEDUSA_WORKER_MODE` to `worker`
4. The worker will handle background jobs

## Step 6: Run Database Migrations

After the first deployment:

1. Go to your Railway project
2. Open the service terminal/logs
3. Or use Railway CLI: `railway run npx medusa db:migrate`

## Step 7: Create Admin User

1. Visit your Railway app URL + `/app`
2. Follow the admin setup process
3. Or create via CLI: `railway run npx medusa user -e admin@example.com -p password`

## Environment Variables Reference

Copy these to your Railway service environment variables:

```
DATABASE_URL=<from_railway_postgresql>
REDIS_URL=<from_railway_redis>
JWT_SECRET=<generate_random_string>
COOKIE_SECRET=<generate_random_string>
NODE_ENV=production
MEDUSA_ADMIN_ONBOARDING_TYPE=default
STORE_CORS=https://your-domain.com
ADMIN_CORS=https://your-railway-app.railway.app
AUTH_CORS=https://your-railway-app.railway.app,https://your-domain.com
MEDUSA_WORKER_MODE=server
```

## Troubleshooting

1. **Build Failures**: Check the build logs in Railway dashboard
2. **Database Connection**: Ensure DATABASE_URL is correctly set
3. **Redis Connection**: Ensure REDIS_URL is correctly set
4. **CORS Issues**: Update CORS environment variables with your actual domains

## Next Steps

1. Set up your custom domain in Railway
2. Configure your storefront to connect to this backend
3. Set up monitoring and logging
4. Configure backup strategies
