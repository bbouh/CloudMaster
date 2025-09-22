import React from 'react';
import { useTranslation } from 'react-i18next';
import { Link } from 'react-router-dom';
import { 
  CloudIcon, 
  AcademicCapIcon, 
  CodeBracketIcon,
  ChartBarIcon,
  ShieldCheckIcon,
  RocketLaunchIcon,
  CheckCircleIcon,
  StarIcon,
  PlayIcon
} from '@heroicons/react/24/outline';
import Hero from '../components/Home/Hero';
import Features from '../components/Home/Features';
import Stats from '../components/Home/Stats';
import Testimonials from '../components/Home/Testimonials';
import PricingSection from '../components/Home/PricingSection';
import CTASection from '../components/Home/CTASection';

const Home: React.FC = () => {
  const { t } = useTranslation();

  return (
    <div className="min-h-screen bg-white dark:bg-gray-900">
      {/* Hero Section */}
      <Hero />
      
      {/* Features Section */}
      <Features />
      
      {/* Stats Section */}
      <Stats />
      
      {/* Learning Paths */}
      <section className="py-20 bg-gray-50 dark:bg-gray-800">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="text-center mb-16">
            <h2 className="text-3xl font-bold text-gray-900 dark:text-white sm:text-4xl">
              {t('home.learningPaths.title')}
            </h2>
            <p className="mt-4 text-lg text-gray-600 dark:text-gray-300">
              {t('home.learningPaths.subtitle')}
            </p>
          </div>
          
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
            {/* AWS Path */}
            <div className="bg-white dark:bg-gray-700 rounded-xl shadow-lg p-8 hover:shadow-xl transition-shadow">
              <div className="flex items-center mb-4">
                <div className="p-3 bg-orange-100 dark:bg-orange-900 rounded-lg">
                  <CloudIcon className="h-8 w-8 text-orange-600 dark:text-orange-400" />
                </div>
                <h3 className="ml-4 text-xl font-semibold text-gray-900 dark:text-white">
                  AWS Cloud
                </h3>
              </div>
              <p className="text-gray-600 dark:text-gray-300 mb-6">
                {t('home.learningPaths.aws.description')}
              </p>
              <div className="space-y-2 mb-6">
                <div className="flex items-center text-sm text-gray-600 dark:text-gray-300">
                  <CheckCircleIcon className="h-4 w-4 text-green-500 mr-2" />
                  {t('home.learningPaths.aws.feature1')}
                </div>
                <div className="flex items-center text-sm text-gray-600 dark:text-gray-300">
                  <CheckCircleIcon className="h-4 w-4 text-green-500 mr-2" />
                  {t('home.learningPaths.aws.feature2')}
                </div>
                <div className="flex items-center text-sm text-gray-600 dark:text-gray-300">
                  <CheckCircleIcon className="h-4 w-4 text-green-500 mr-2" />
                  {t('home.learningPaths.aws.feature3')}
                </div>
              </div>
              <Link
                to="/curriculum?path=aws"
                className="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-orange-600 hover:bg-orange-700 transition-colors"
              >
                {t('common.startLearning')}
                <RocketLaunchIcon className="ml-2 h-4 w-4" />
              </Link>
            </div>

            {/* Azure Path */}
            <div className="bg-white dark:bg-gray-700 rounded-xl shadow-lg p-8 hover:shadow-xl transition-shadow">
              <div className="flex items-center mb-4">
                <div className="p-3 bg-blue-100 dark:bg-blue-900 rounded-lg">
                  <CloudIcon className="h-8 w-8 text-blue-600 dark:text-blue-400" />
                </div>
                <h3 className="ml-4 text-xl font-semibold text-gray-900 dark:text-white">
                  Microsoft Azure
                </h3>
              </div>
              <p className="text-gray-600 dark:text-gray-300 mb-6">
                {t('home.learningPaths.azure.description')}
              </p>
              <div className="space-y-2 mb-6">
                <div className="flex items-center text-sm text-gray-600 dark:text-gray-300">
                  <CheckCircleIcon className="h-4 w-4 text-green-500 mr-2" />
                  {t('home.learningPaths.azure.feature1')}
                </div>
                <div className="flex items-center text-sm text-gray-600 dark:text-gray-300">
                  <CheckCircleIcon className="h-4 w-4 text-green-500 mr-2" />
                  {t('home.learningPaths.azure.feature2')}
                </div>
                <div className="flex items-center text-sm text-gray-600 dark:text-gray-300">
                  <CheckCircleIcon className="h-4 w-4 text-green-500 mr-2" />
                  {t('home.learningPaths.azure.feature3')}
                </div>
              </div>
              <Link
                to="/curriculum?path=azure"
                className="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-blue-600 hover:bg-blue-700 transition-colors"
              >
                {t('common.startLearning')}
                <RocketLaunchIcon className="ml-2 h-4 w-4" />
              </Link>
            </div>

            {/* DevOps Path */}
            <div className="bg-white dark:bg-gray-700 rounded-xl shadow-lg p-8 hover:shadow-xl transition-shadow">
              <div className="flex items-center mb-4">
                <div className="p-3 bg-green-100 dark:bg-green-900 rounded-lg">
                  <CodeBracketIcon className="h-8 w-8 text-green-600 dark:text-green-400" />
                </div>
                <h3 className="ml-4 text-xl font-semibold text-gray-900 dark:text-white">
                  DevOps & SRE
                </h3>
              </div>
              <p className="text-gray-600 dark:text-gray-300 mb-6">
                {t('home.learningPaths.devops.description')}
              </p>
              <div className="space-y-2 mb-6">
                <div className="flex items-center text-sm text-gray-600 dark:text-gray-300">
                  <CheckCircleIcon className="h-4 w-4 text-green-500 mr-2" />
                  {t('home.learningPaths.devops.feature1')}
                </div>
                <div className="flex items-center text-sm text-gray-600 dark:text-gray-300">
                  <CheckCircleIcon className="h-4 w-4 text-green-500 mr-2" />
                  {t('home.learningPaths.devops.feature2')}
                </div>
                <div className="flex items-center text-sm text-gray-600 dark:text-gray-300">
                  <CheckCircleIcon className="h-4 w-4 text-green-500 mr-2" />
                  {t('home.learningPaths.devops.feature3')}
                </div>
              </div>
              <Link
                to="/curriculum?path=devops"
                className="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-green-600 hover:bg-green-700 transition-colors"
              >
                {t('common.startLearning')}
                <RocketLaunchIcon className="ml-2 h-4 w-4" />
              </Link>
            </div>
          </div>
        </div>
      </section>

      {/* Testimonials */}
      <Testimonials />
      
      {/* Pricing */}
      <PricingSection />
      
      {/* CTA */}
      <CTASection />
    </div>
  );
};

export default Home;
