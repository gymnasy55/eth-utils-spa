import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react-refresh';

export default defineConfig({
  plugins: [
    react(),
  ],
  build: {
    watch: false,
    sourcemap: true,
    polyfillDynamicImport: false,
    target: 'esnext',
    rollupOptions: {
      output: {
        format: 'esm',
        manualChunks: {
          react: ['react', 'react-dom'],
        },
      },
    },
  },
  optimizeDeps: {
    esbuildOptions: {
      target: 'esnext',
    },
  },
  clearScreen: false,
});