
# Vulnerable Go App

This is a simple Go server that listens on port 3000 and responds with "hello I'm vulnerable!". It is packaged in a Docker container and deployed to a Kubernetes cluster using the provided `deploy.yaml`.

## Features

- A minimal Go web server listening on port 3000.
- Deployed as a Kubernetes Deployment and exposed via a LoadBalancer service.

## Requirements

- Docker
- Kubernetes cluster (Minikube, GKE, EKS, AKS, etc.)
- `kubectl` installed and configured to connect to your Kubernetes cluster.

## Getting Started

### 1. Build the Docker Image

Make sure you have Docker installed. Build the image with the following command:

```bash
docker build -t lkup77/test_vuln_go:1 .
```

### 2. Push the Docker Image

After building the image, push it to Docker Hub or your preferred container registry:

```bash
docker push lkup77/test_vuln_go:1
```

### 3. Deploy to Kubernetes

Deploy the app using the provided `deploy.yaml` file. Make sure `kubectl` is configured to connect to your Kubernetes cluster.

```bash
kubectl apply -f deploy.yaml
```

This will create:
- A `Namespace` named `go-app-lk`.
- A `Deployment` with your Go app running in a pod.
- A `Service` of type `LoadBalancer` that exposes port 3000 of the app.

### 4. Access the App

To get the external IP address of the service, run:

```bash
kubectl get services -n go-app-lk
```

Once the external IP is available, access the application by visiting:

```
http://<EXTERNAL-IP>:3000
```

You should see the message:

```
hello I'm vulnerable!
```

## Cleanup

To delete the deployment, service, and namespace, run:

```bash
kubectl delete namespace go-app-lk
```

## License

This project is open-source and available under the MIT License.
