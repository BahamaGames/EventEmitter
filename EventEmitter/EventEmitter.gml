/*
by		: BAHAMAGAMES / rickky
GMail	: bahamagames@gmail.com 
Discord	: rickky#1696
GitHub	: https://github.com/BahamaGames/EventEmitter
*/
// feather ignore all

//listensers = [listeners:[event:[listener, ephemeral?],], size]
function EventEmitter()			constructor
{
	/// @function addListener(event, listener, [context])
	static addListener			= function(____event, ____listener, ____context = self)
	{
		return on(____event, ____listener, ____context);
	}
	
	/// @function emit(event, [args 1 - 15])
	static emit					= function(____event)
	{
		var ___array	= _event_listeners[$ ____event];
		if(___array == undefined) return self;
		
		var 
		i				= 0,
		___val			= undefined,
		___size			= ___array[1],
		___listeners	= ___array[0];
		
		if(___size == 0) return self;
		
		repeat(___size) 
		{
			var ___event = ___listeners[i];
			//If the event was set to trigger once
			if(!___event[1]) i++;
			else {
				//Remove it
				array_delete(___listeners, i, 1);
				___array[@ 1]--;
			}
			
			switch(argument_count)
			{
				case 1:		var ___val = ___event[0](); break;
				case 2:		var ___val = ___event[0](argument[1]); break;
				case 3:		var ___val = ___event[0](argument[1], argument[2]); break;
				case 4:		var ___val = ___event[0](argument[1], argument[2], argument[3]); break;
				case 5:		var ___val = ___event[0](argument[1], argument[2], argument[3], argument[4]); break;
				case 6:		var ___val = ___event[0](argument[1], argument[2], argument[3], argument[4], argument[5]); break;
				case 7:		var ___val = ___event[0](argument[1], argument[2], argument[3], argument[4], argument[5], argument[6]); break;
				case 8:		var ___val = ___event[0](argument[1], argument[2], argument[3], argument[4], argument[5], argument[6], argument[7]); break;
				case 9:		var ___val = ___event[0](argument[1], argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8]); break;
				case 10:	var ___val = ___event[0](argument[1], argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9]); break;
				case 11:	var ___val = ___event[0](argument[1], argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10]); break;
				case 12:	var ___val = ___event[0](argument[1], argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11]); break;
				case 13:	var ___val = ___event[0](argument[1], argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12]); break;
				case 14:	var ___val = ___event[0](argument[1], argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13]); break;
				case 15:	var ___val = ___event[0](argument[1], argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13], argument[14]); break;
				case 16:	var ___val = ___event[0](argument[1], argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13], argument[14], argument[15]); break;
			}
			
			if(___val != undefined) return ___val;
			
			if(i == ___size - 1 && array_length(___listeners) < ___size) return self;
		}
		
		return self;
	}
	
	/// @function on(event, listener, [context])
	static on					= function(____event, ____listener, ____context = self)
	{
		var 
		___event				= _event_listeners[$ ____event],
		___listeners			= ___event;
		
		if(___event == undefined)
		{
			___listeners		= [[], 0];
			array_push(_event_names, ____event);
			_event_listeners[$ ____event] = ___listeners;
		}
		
		array_push(___listeners[0], [method(____context, ____listener), false]);
		___listeners[@ 1]++;
		return self;
	}
	
	/// @function once(event, listener, [context])
	static once					= function(____event, ____listener, ____context = self)
	{
		var 
		___event				= _event_listeners[$ ____event],
		___listeners			= ___event;
		
		if(___event == undefined)
		{
			___listeners		= [[], 0];
			array_push(_event_names, ____event);
			_event_listeners[$ ____event] = ___listeners;
		}
		
		array_push(___listeners[0], [method(____context, ____listener), true]);
		___listeners[@ 1]++;
		return self;
	}
	
	/// @function removeListener(event, listener, [context])
	static removeListener		= function(____event, ____listener, ____context = self)
	{
		var ___array	= _event_listeners[$ ____event];
		if(___array == undefined) return self;
		
		var ___size		= ___array[1];
		
		if(___size > 0)
		{
			var
			___listeners	= ___array[@ 0];
			____listener	= string(method(____context, ____listener));
		
			for(var i = 0; i < ___size; ++i)
				if(____listener == string(___listeners[i][0]))
				{
					array_delete(___listeners, i, 1);
					___array[@ 1]--;
					return self;	
				}
		}
		return self;
	}
	
	/// @function off(event, listener, [context])
	static off					= function(____event, ____listener, ____context = self)
	{
		return removeListener(____event, ____listener, ____context);
	}
	
	/// @function removeAllListeners(event)
	static removeAllListeners	= function(____event = undefined)
	{
		if(____event == undefined)
			struct_foreach(_event_listeners, function(k, v)
			{
				v[@ 0] = [];
				v[@ 1] = 0;
			});
		else {
			var ___array	= _event_listeners[$ ____event];
			if(___array == undefined) return self;
			
			___array[@ 0]	= [];
			___array[@ 1]	= 0;
		}
		
		return self;
	}
	
	/// @function setMaxListeners(n)
	static setMaxListeners		= function(n)
	{
		_event_max_listeners = n;
		return self;
	}
	
	/// @function getMaxListeners()
	static getMaxListeners		= function()
	{
		return _event_max_listeners;
	}
	
	/// @function listeners(eventName)
	static listeners			= function(____event_name)
	{
		var 
		e = _event_listeners[$ ____event_name],
		s = e[1],
		a = array_create(s);
		array_copy(a, 0, e[0], 0, s);
		return a;
	}
	
	/// @function prependListener(event, listener, context)
	static prependListener		= function(____event, ____listener, ____context = self)
	{
		var 
		___event				= _event_listeners[$ ____event],
		___listeners			= ___event;
		
		if(___event == undefined)
		{
			___listeners		= [[], 0];
			array_push(_event_names, ____event);
			_event_listeners[$ ____event] = ___listeners;
		}
		
		array_insert(___listeners[0], 0, [method(____context, ____listener), false]);
		___listeners[@ 1]++;
		return self;
	}
	
	/// @function prependOnceListener(event, listener, context)
	static prependOnceListener	= function(____event, ____listener, ____context = self)
	{
		var 
		___event				= _event_listeners[$ ____event],
		___listeners			= ___event;
		
		if(___event == undefined)
		{
			___listeners		= [[], 0];
			array_push(_event_names, ____event);
			_event_listeners[$ ____event] = ___listeners;
		}
		
		array_insert(___listeners[0], 0, [method(____context, ____listener), true]);
		___listeners[@ 1]++;
		return self;
	}
	
	/// @function eventNames()
	static eventNames			= function()
	{
		return _event_names;	
	}
	
	/// @function listenerCount(event)
	static listenerCount		= function(____event)
	{
		var ___event = _event_listeners[$ ____event];
		return ___event != undefined? ___event[1]: 0;
	}
	
	_event_max_listeners		= 10;
	_event_listeners			= {};
	_event_names				= [];
}