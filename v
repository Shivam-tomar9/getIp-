First create an middleware GetIpMidddleware
<?php

namespace App\Http\Middleware;

use Closure;
use DB;

class GetIpMiddleware
{
    public function handle($request, Closure $next)
    {
        // Add your logic to get the IP address here


        $ip = $request->ip();


     
       $ips=[
         "ip_addresses"  => $ip,
         "created_at" => date('Y-m-d H:i:s'),
         "updated_at" =>  date('Y-m-d H:i:s'),
       ];

      $insert=DB::table('ip_address')->insert($ips);




      
        return $next($request);
    }
}

and then mention in Kernel.php
  protected $routeMiddleware = [
        'auth' => \App\Http\Middleware\Authenticate::class,
        'auth.basic' => \Illuminate\Auth\Middleware\AuthenticateWithBasicAuth::class,
        'auth.session' => \Illuminate\Session\Middleware\AuthenticateSession::class,
        'cache.headers' => \Illuminate\Http\Middleware\SetCacheHeaders::class,
        'can' => \Illuminate\Auth\Middleware\Authorize::class,
        'guest' => \App\Http\Middleware\RedirectIfAuthenticated::class,
        'password.confirm' => \Illuminate\Auth\Middleware\RequirePassword::class,
        'signed' => \App\Http\Middleware\ValidateSignature::class,
        'throttle' => \Illuminate\Routing\Middleware\ThrottleRequests::class,
        'verified' => \Illuminate\Auth\Middleware\EnsureEmailIsVerified::class,
        'PreventBackHistory' => \App\Http\Middleware\PreventBackHistory::class,
        'checkRole' => \App\Http\Middleware\CheckRole::class,
        'getIp' => \App\Http\Middleware\GetIpMiddleware::class,
    ];

now add middleware in your web.php
Route::get('/', [WebsiteController::class, 'index'])->name('website.index')->middleware('getIp');
