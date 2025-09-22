import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import { ToastContainer } from 'react-toastify';
import { AuthProvider } from './contexts/AuthContext';
import { ThemeProvider } from './contexts/ThemeContext';
import { LanguageProvider } from './contexts/LanguageContext';
import Layout from './components/Layout/Layout';
import ProtectedRoute from './components/Auth/ProtectedRoute';
import AdminRoute from './components/Auth/AdminRoute';

// Pages
import Home from './pages/Home';
import About from './pages/About';
import Contact from './pages/Contact';
import Pricing from './pages/Pricing';
import Terms from './pages/Terms';
import Privacy from './pages/Privacy';
import Login from './pages/Auth/Login';
import Register from './pages/Auth/Register';
import ForgotPassword from './pages/Auth/ForgotPassword';
import ResetPassword from './pages/Auth/ResetPassword';
import Curriculum from './pages/Curriculum';
import Course from './pages/Course';
import Lesson from './pages/Lesson';
import Lab from './pages/Lab';
import Quiz from './pages/Quiz';
import Projects from './pages/Projects';
import Profile from './pages/Profile';
import Dashboard from './pages/Admin/Dashboard';
import AdminCourses from './pages/Admin/Courses';
import AdminUsers from './pages/Admin/Users';
import AdminAnalytics from './pages/Admin/Analytics';
import NotFound from './pages/NotFound';

// Import CSS
import 'react-toastify/dist/ReactToastify.css';
import './i18n/i18n';

// Create a client
const queryClient = new QueryClient({
  defaultOptions: {
    queries: {
      retry: 1,
      refetchOnWindowFocus: false,
    },
  },
});

function App() {
  return (
    <QueryClientProvider client={queryClient}>
      <ThemeProvider>
        <LanguageProvider>
          <AuthProvider>
            <Router>
              <div className="App">
                <Routes>
                  {/* Public Routes */}
                  <Route path="/" element={<Layout><Home /></Layout>} />
                  <Route path="/about" element={<Layout><About /></Layout>} />
                  <Route path="/contact" element={<Layout><Contact /></Layout>} />
                  <Route path="/pricing" element={<Layout><Pricing /></Layout>} />
                  <Route path="/terms" element={<Layout><Terms /></Layout>} />
                  <Route path="/privacy" element={<Layout><Privacy /></Layout>} />
                  <Route path="/curriculum" element={<Layout><Curriculum /></Layout>} />
                  
                  {/* Auth Routes */}
                  <Route path="/login" element={<Login />} />
                  <Route path="/register" element={<Register />} />
                  <Route path="/forgot-password" element={<ForgotPassword />} />
                  <Route path="/reset-password/:token" element={<ResetPassword />} />
                  
                  {/* Protected Routes */}
                  <Route path="/course/:id" element={
                    <ProtectedRoute>
                      <Layout><Course /></Layout>
                    </ProtectedRoute>
                  } />
                  <Route path="/lesson/:id" element={
                    <ProtectedRoute>
                      <Layout><Lesson /></Layout>
                    </ProtectedRoute>
                  } />
                  <Route path="/lab/:id" element={
                    <ProtectedRoute>
                      <Layout><Lab /></Layout>
                    </ProtectedRoute>
                  } />
                  <Route path="/quiz/:id" element={
                    <ProtectedRoute>
                      <Layout><Quiz /></Layout>
                    </ProtectedRoute>
                  } />
                  <Route path="/projects" element={
                    <ProtectedRoute>
                      <Layout><Projects /></Layout>
                    </ProtectedRoute>
                  } />
                  <Route path="/profile" element={
                    <ProtectedRoute>
                      <Layout><Profile /></Layout>
                    </ProtectedRoute>
                  } />
                  
                  {/* Admin Routes */}
                  <Route path="/admin" element={
                    <AdminRoute>
                      <Layout><Dashboard /></Layout>
                    </AdminRoute>
                  } />
                  <Route path="/admin/courses" element={
                    <AdminRoute>
                      <Layout><AdminCourses /></Layout>
                    </AdminRoute>
                  } />
                  <Route path="/admin/users" element={
                    <AdminRoute>
                      <Layout><AdminUsers /></Layout>
                    </AdminRoute>
                  } />
                  <Route path="/admin/analytics" element={
                    <AdminRoute>
                      <Layout><AdminAnalytics /></Layout>
                    </AdminRoute>
                  } />
                  
                  {/* 404 Route */}
                  <Route path="*" element={<Layout><NotFound /></Layout>} />
                </Routes>
                
                <ToastContainer
                  position="top-right"
                  autoClose={5000}
                  hideProgressBar={false}
                  newestOnTop={false}
                  closeOnClick
                  rtl={false}
                  pauseOnFocusLoss
                  draggable
                  pauseOnHover
                  theme="light"
                />
              </div>
            </Router>
          </AuthProvider>
        </LanguageProvider>
      </ThemeProvider>
    </QueryClientProvider>
  );
}

export default App;
