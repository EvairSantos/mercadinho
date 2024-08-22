<?php

return [
    '/' => 'ProductController@index',
    '/product/show/(\d+)' => 'ProductController@show',
    '/product/create' => 'ProductController@create',
    '/product/update/(\d+)' => 'ProductController@update',
    '/product/delete/(\d+)' => 'ProductController@delete',
];
