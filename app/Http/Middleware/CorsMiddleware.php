<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;

class CorsMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle(Request $request, Closure $next)
    {
        $allowed_origins = [
            'https://book-heaven-henna.vercel.app',
            'https://book-heaven-three.vercel.app',
            'https://bookheaven-bpqajtzog-krisr3710-1367s-projects.vercel.app',
            'https://book-heaven-git-main-krisr3710-1367s-projects.vercel.app',
            'https://book-heaven-91xytffpj-krisr3710-1367s-projects.vercel.app',
            'http://localhost:3000',
            'http://localhost:5173',
        ];

        $origin = $request->header('Origin');

        if (in_array($origin, $allowed_origins)) {
            return $next($request)
                ->header('Access-Control-Allow-Origin', $origin)
                ->header('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS, PATCH')
                ->header('Access-Control-Allow-Headers', 'Content-Type, Authorization, X-Requested-With')
                ->header('Access-Control-Allow-Credentials', 'true')
                ->header('Access-Control-Max-Age', '3600');
        }

        if ($request->getMethod() === "OPTIONS") {
            return response('')
                ->header('Access-Control-Allow-Origin', $origin)
                ->header('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS, PATCH')
                ->header('Access-Control-Allow-Headers', 'Content-Type, Authorization, X-Requested-With')
                ->header('Access-Control-Allow-Credentials', 'true')
                ->header('Access-Control-Max-Age', '3600');
        }

        return $next($request);
    }
}
