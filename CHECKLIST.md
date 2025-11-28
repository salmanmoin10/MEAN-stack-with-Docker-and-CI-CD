# Deployment Checklist

Use this checklist to track your progress through the deployment process.

## ☐ Phase 1: Repository Setup

### GitHub Repository

- [ ] Created GitHub account (if needed)
- [ ] Created new repository
- [ ] Initialized local git repository
- [ ] Added all files to git
- [ ] Committed initial changes
- [ ] Added remote origin
- [ ] Pushed code to GitHub
- [ ] Verified all files are on GitHub

**Screenshot**: Repository overview showing all files

---

## ☐ Phase 2: Docker Hub Setup

### Docker Hub Account

- [ ] Created Docker Hub account
- [ ] Verified email address
- [ ] Generated access token
- [ ] Saved access token securely
- [ ] Tested Docker Hub login locally

**Screenshot**: Docker Hub dashboard

---

## ☐ Phase 3: Local Docker Build

### Build Configuration

- [ ] Created `.env` file with Docker Hub username
- [ ] Built backend Docker image
- [ ] Built frontend Docker image
- [ ] Tested images locally with docker-compose
- [ ] Verified application works locally
- [ ] Pushed backend image to Docker Hub
- [ ] Pushed frontend image to Docker Hub
- [ ] Verified images on Docker Hub

**Screenshots**:

- Docker build process
- Docker Hub repositories

---

## ☐ Phase 4: Cloud VM Setup

### Infrastructure

- [ ] Created cloud provider account (AWS/Azure/GCP)
- [ ] Created Ubuntu 22.04 VM
- [ ] Configured security groups (ports 22, 80)
- [ ] Generated SSH key pair
- [ ] Connected to VM via SSH
- [ ] Updated system packages
- [ ] Installed Docker on VM
- [ ] Installed Docker Compose on VM
- [ ] Added user to docker group
- [ ] Verified Docker installation

**Screenshots**:

- VM dashboard
- VM configuration details

---

## ☐ Phase 5: Application Deployment

### Deploy to VM

- [ ] Created ~/mean-app directory on VM
- [ ] Cloned GitHub repository to VM
- [ ] Created `.env` file on VM
- [ ] Made deploy.sh executable
- [ ] Pulled Docker images on VM
- [ ] Ran deploy.sh script
- [ ] Verified all 4 containers running
- [ ] Checked container logs
- [ ] Tested application from VM (curl localhost)
- [ ] Accessed application from browser (http://VM_IP)

**Screenshots**:

- Docker containers running (docker ps)
- Application in browser

---

## ☐ Phase 6: CI/CD Pipeline

### GitHub Actions Setup

- [ ] Generated SSH key for CI/CD
- [ ] Added public key to VM
- [ ] Tested SSH connection with private key
- [ ] Added DOCKER_USERNAME to GitHub secrets
- [ ] Added DOCKER_PASSWORD to GitHub secrets
- [ ] Added SERVER_HOST to GitHub secrets
- [ ] Added SERVER_USER to GitHub secrets
- [ ] Added SSH_PRIVATE_KEY to GitHub secrets
- [ ] Verified workflow file exists
- [ ] Made test commit to trigger pipeline
- [ ] Monitored pipeline execution
- [ ] Verified all steps completed successfully
- [ ] Checked auto-deployment on VM

**Screenshots**:

- GitHub secrets configuration
- GitHub Actions workflow run
- Pipeline steps completion

---

## ☐ Phase 7: Testing

### Functional Testing

- [ ] Created a tutorial
- [ ] Viewed tutorials list
- [ ] Updated a tutorial
- [ ] Searched for tutorial by title
- [ ] Deleted a tutorial
- [ ] Tested all API endpoints

### Integration Testing

- [ ] Made code change locally
- [ ] Committed and pushed to GitHub
- [ ] Watched CI/CD pipeline trigger
- [ ] Verified automatic deployment
- [ ] Confirmed changes live on VM
- [ ] Tested updated application

**Screenshots**:

- Application UI showing all pages
- Tutorial list with data
- Add/edit tutorial forms

---

## ☐ Phase 8: Documentation

### Screenshots

- [ ] GitHub repository overview
- [ ] GitHub Actions workflow
- [ ] Successful pipeline execution
- [ ] Docker Hub repositories
- [ ] Backend image details
- [ ] Frontend image details
- [ ] VM dashboard
- [ ] Docker containers running
- [ ] Application home page
- [ ] Tutorials list page
- [ ] Add tutorial page
- [ ] Tutorial details page
- [ ] Nginx configuration

### Documentation Files

- [ ] README.md is complete
- [ ] All screenshots added to .screenshots/
- [ ] Screenshots referenced in README
- [ ] DEPLOYMENT_GUIDE.md reviewed
- [ ] QUICK_REFERENCE.md reviewed

---

## ☐ Phase 9: Final Verification

### Complete Checklist

- [ ] All containers running on VM
- [ ] Application accessible via http://VM_IP
- [ ] Nginx reverse proxy working
- [ ] Backend API responding
- [ ] MongoDB data persisting
- [ ] CI/CD pipeline functional
- [ ] Auto-deployment working
- [ ] All screenshots documented
- [ ] README.md comprehensive
- [ ] GitHub repository complete

### Test Complete Workflow

- [ ] Make a change to backend/server.js
- [ ] Commit and push to GitHub
- [ ] Watch GitHub Actions build images
- [ ] See images pushed to Docker Hub
- [ ] Verify auto-deployment to VM
- [ ] Confirm change is live
- [ ] Test all functionality still works

**Screenshot**: Complete workflow from commit to deployment

---

## ☐ Final Deliverable

### Repository Submission

- [ ] All code committed and pushed
- [ ] All screenshots added
- [ ] README.md updated with screenshots
- [ ] Repository URL ready to share
- [ ] VM is running (don't delete!)
- [ ] Can demonstrate CI/CD if needed

### What Your Repository Should Include

```
✓ Backend Dockerfile
✓ Frontend Dockerfile
✓ docker-compose.yml
✓ nginx/nginx.conf
✓ .github/workflows/deploy.yml
✓ deploy.sh
✓ README.md with screenshots
✓ DEPLOYMENT_GUIDE.md
✓ QUICK_REFERENCE.md
✓ All application code
✓ .dockerignore files
✓ .gitignore file
✓ .env.example
```

---

## 📊 Time Estimates

| Phase                           | Estimated Time |
| ------------------------------- | -------------- |
| Phase 1: Repository Setup       | 10 minutes     |
| Phase 2: Docker Hub Setup       | 5 minutes      |
| Phase 3: Local Docker Build     | 15 minutes     |
| Phase 4: Cloud VM Setup         | 20 minutes     |
| Phase 5: Application Deployment | 15 minutes     |
| Phase 6: CI/CD Pipeline         | 20 minutes     |
| Phase 7: Testing                | 15 minutes     |
| Phase 8: Documentation          | 15 minutes     |
| Phase 9: Final Verification     | 10 minutes     |
| **Total**                       | **~2 hours**   |

---

## 🆘 Having Issues?

### Quick Troubleshooting

- [ ] Checked container logs: `docker-compose logs`
- [ ] Verified ports not in use: `netstat -ano | findstr :80`
- [ ] Confirmed MongoDB is running: `docker ps | grep mongodb`
- [ ] Tested backend directly: `curl http://localhost:8080`
- [ ] Reviewed GitHub Actions logs
- [ ] Verified all GitHub secrets set correctly
- [ ] Checked VM security groups
- [ ] Confirmed SSH key works

### Resources

- Read DEPLOYMENT_GUIDE.md for detailed instructions
- Check QUICK_REFERENCE.md for common commands
- Review troubleshooting section in README.md

---

## ✅ Success Criteria

You're done when:

1. ✅ Application accessible at http://YOUR_VM_IP
2. ✅ All CRUD operations working
3. ✅ Push to GitHub triggers automatic deployment
4. ✅ Docker images on Docker Hub
5. ✅ Complete documentation with screenshots
6. ✅ VM infrastructure maintained (not deleted)

---

## 🎯 Ready to Submit

- [ ] GitHub repository URL: ****************\_****************
- [ ] Docker Hub username: ****************\_****************
- [ ] VM IP address: ****************\_****************
- [ ] Application URL: http://****************\_****************
- [ ] All screenshots included: Yes / No
- [ ] CI/CD tested and working: Yes / No
- [ ] VM kept running: Yes / No

**Date Completed**: **********\_**********

**Ready for Demo**: Yes / No

---

**Congratulations on completing the MEAN Stack DevOps Deployment!** 🎉
