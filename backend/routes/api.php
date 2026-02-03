<?php

use Illuminate\Support\Facades\Route;

Route::prefix('v1')->group(function () {
    Route::post('auth/login', 'AuthController@login');
    Route::post('auth/logout', 'AuthController@logout');
    Route::get('auth/me', 'AuthController@me');

    Route::middleware('auth:api')->group(function () {
        Route::get('roles', 'RoleController@index');
        Route::apiResource('users', 'UserController')->except(['destroy']);
        Route::post('users/{id}/archive', 'UserController@archive');

        Route::apiResource('articles', 'ArticleController')->except(['destroy']);
        Route::post('articles/{id}/archive', 'ArticleController@archive');
        Route::post('articles/{id}/images', 'ArticleController@storeImage');
        Route::apiResource('variants', 'VariantController')->except(['destroy']);

        Route::get('stock/balances', 'StockController@balances');
        Route::get('stock/ledger', 'StockController@ledger');
        Route::post('stock/movements', 'StockController@storeMovement');

        Route::apiResource('orders', 'OrderController')->except(['destroy']);
        Route::post('orders/{id}/cancel', 'OrderController@cancel');
        Route::post('returns', 'ReturnController@store');
        Route::post('returns/{id}/approve', 'ReturnController@approve');

        Route::apiResource('fabrics', 'FabricController')->except(['destroy']);
        Route::post('fabrics/{id}/consume', 'FabricController@consume');

        Route::apiResource('accessories', 'AccessoryController')->except(['destroy']);
        Route::post('accessories/{id}/use', 'AccessoryController@use');

        Route::apiResource('productions', 'ProductionController')->except(['destroy']);

        Route::apiResource('locations', 'LocationController')->except(['destroy']);
        Route::apiResource('transfers', 'TransferController')->except(['destroy']);
        Route::post('transfers/{id}/receive', 'TransferController@receive');

        Route::get('reports/fast-moving', 'ReportController@fastMoving');
        Route::get('reports/dead-stock', 'ReportController@deadStock');
        Route::get('reports/size-shortage', 'ReportController@sizeShortage');
        Route::get('reports/fabric-consumption', 'ReportController@fabricConsumption');
        Route::get('reports/profit-per-article', 'ReportController@profitPerArticle');
        Route::get('reports/season-sales', 'ReportController@seasonSales');
    });
});
