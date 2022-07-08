global coords maxSize coolArray
coords = [0,0];
maxSize = 50;
coolArray;

start();

function start()

    global coords maxSize coolArray

    coolArray = zeros(80, maxSize);

    % two temp filler arrays
    assignin('base', 'arrayIn', 1:80);
    assignin('base', 'arrayOut', (1:80)*2);

    % create uifigure and pause button
    fig = uifigure(800,800);
    pb = uibutton(fig, 'state', 'Position', [400, 300, 100, 22], 'Text', "Pause");
    pb.Value = false;

    sb = uibutton(fig, 'state', 'Position', [400, 200, 100, 22], 'Text', "Restart");
    sb.Value = false;

    fsb = uibutton(fig, 'state', 'Position', [400, 100, 100, 22], 'Text', "Stop");
    fsb.Value = false;

    % get coordinates
%             ax3 = uiaxes(fig, 'Position', [100, 10, 100, 100]);
%             imshow('image.jpg', 'Parent', ax3);
    cords = getCoords(fig);
    assignin('base', 'cords', cords);
    
    % while not stopped, check if paused
    while  (~fsb.Value)

        if (sb.Value)
            restart(fig);
        end

        % update if not paused
        if (~pb.Value)

%                     if(newArray)
                showArray(fig);
%                     if(new arrayOut)
                updateMap(fig);
            pause(0.01);
        end

        drawnow();
    end

    close all force;

end



function restart(fig)

    global coords maxSize coolArray

    close all;
    coolArray = zeros(80, maxSize);
    
    pb = uibutton(fig, 'state', 'Position', [400, 300, 100, 22], 'Text', "Pause Button");
    pb.Value = false;
    sb = uibutton(fig, 'state', 'Position', [400, 200, 100, 22], 'Text', "Restart Button");
    sb.Value = false;
    fsb = uibutton(fig, 'state', 'Position', [400, 100, 100, 22], 'Text', "Stop");
    fsb.Value = false;


    imshow('image.jpg');
    cords = getCoords();
    assignin('base', 'cords', cords);
    
    % while not stopped, check if paused
    while  (~fsb.Value)

        if (sb.Value)
            restart(fig);
        end

        % update if not paused
        if (~pb.Value)

%                     if(newArray)
                showArray(fig);
%                     if(new arrayOut)
                updateMap(fig);
            pause(0.01);
        end

        drawnow();
    end

    close all force;

end


function x = getCoords(f)
    global coords maxSize coolArray
%     ax3 = uiaxes(f, 'Position', [50, 200, 100, 100]);
%     imshow('image.jpg', 'Parent', ax3);
%     coords = ginputax(f, ax3);
    imshow('image.jpg');
    coords = ginput(1);
    x = coords;
%             assignin('base', 'coords', .coords);
end

% gets inputted array and displays
function showArray(f)
    global coords maxSize coolArray
    ax = uiaxes(f, 'Position', [50 250 150 150]);
    plot(ax, evalin('base', 'arrayIn'));
end

% updates grayscale map with new array
function updateMap(f)
    global coords maxSize coolArray
    arrayOut = evalin('base', 'arrayOut');
    arrayOut = arrayOut';
    
    temp = max(arrayOut);
    arrayOut = arrayOut/temp;

    coolArray = [arrayOut, coolArray];
    if (size(coolArray, 2) > maxSize)
        coolArray(:,maxSize + 1) = [];
    end
    
    ax2 = uiaxes(f, 'Position', [0, 0, 200, 200]);
    imshow(coolArray, 'Parent', ax2);

end