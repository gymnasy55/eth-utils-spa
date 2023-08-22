import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react-refresh';
import * as path from 'path';

export default defineConfig({
  root: path.join(__dirname, 'src'),
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