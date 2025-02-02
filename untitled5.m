picture = imread( 'cat.jpg' );
graytone = rgb2gray( picture );

% Calculate the threshold value
threshold = graythresh( graytone );

% Print the threshold value on the screen
disp( [ 'Treshold Value: ' num2str( threshold ) ] );

% Create the thresholded image
picture_of_thresold = imbinarize( graytone, thresold );

% Visualize the images
subplot( 1, 2, 1 );
imshow( graytone );
title( 'Orijinal Picture' );

subplot(1, 2, 2);
imshow( picture_of_thresold );
title( 'Thresholded Image' );

% Define the largest white area and mask the remaining region
restricted_image = imfill( picture_of_threshold, 'holes' );
mask = restricted_image;
mask = bwareaopen( mask, 1000 );
final_visual = graytone;
final_visual( ~mask ) = 0;

% Determine the left-right and top-bottom corner boundaries
stats = regionprops( mask, 'BoundingBox' );
boundingBox = stats.BoundingBox;

x = boundingBox( 1 );
y = boundingBox( 2 );
width = boundingBox( 3 );
height = boundingBox( 4 );

left_point = [ x, y ];
right_point = [ x t+ width, y ];
top_point = [ x, y ];
bottom_point = [ x, y + height ];

% Create the image matrix representing the desired output format
print_picture = zeros( size( final_visual ) );

% Copy each pixel of the masked image to the appropriate index value in the output image matrix by calculating the required index value
for i = 1:size( final_visual, 1 )
    for j = 1:size( final_visual, 2 )
        if maske( i, j )
            print_picture( i, j ) = final_visual(i, j);
        end
    end
end

% Apply a median filter to the unprocessed pixels in the output image matrix
filter_picture = medfilt2( print_picture, [ 1 1 ] );

% Save the obtained image as the output file
fig = figure;
imshow( filter_picture );
hold on;
line( [ left_point( 1 ), right_point( 1 ) ], [ left_point( 2 ), left_point( 2 )], 'Color', 'red', 'LineWidth', 2 );
line( [ left_point( 1 ), right_point( 1 ) ], [ bottom_point( 2 ), bottom_point( 2 ) ], 'Color', 'red', 'LineWidth', 2 );
line( [ left_point( 1 ), left_point( 1 ) ], [ top_point( 2 ), bottom_point( 2 ) ], 'Color', 'red', 'LineWidth', 2 );
line( [ right_point( 1 ), right_point( 1 ) ], [ top_point( 2 ), bottom_point( 2 ) ], 'Color', 'red', 'LineWidth', 2 );
title( 'Result Image and Borders' );
hold off;

% Crop the borders and display
cuttingoff_picture = imcrop( filter_picture, boundingBox );
imshow( cuttingoff_picture );
title( 'Cropped Image' );

% Visualize the result and draw the boundaries
print( fig, '150_cat.jpg', '-r150', '-dpng' );
