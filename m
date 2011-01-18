From: Raviraj <raviraj.bhat@globaledgesoft.com>
Date: Tue, 18 Jan 2011 07:52:04 +0000
Subject: Re: Camera select time out error
Message-Id: <4D3546E1.1030505@globaledgesoft.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4D352AD4.4080908@globaledgesoft.com>
In-Reply-To: <4D352AD4.4080908@globaledgesoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

I haven't checked with mplayer or other standard v4l2 applications.

But i have written sample capture code (similar to capture.c in v4l2 
documentation). Even that
sample code gives the same error.

One thing I have observed is if i capture from 2 cameras simultaneously, 
i will get the error sooner ie.
within 2-3 runs.

Regards,
Raviraj Bhat.


On Tuesday 18 January 2011 12:37 PM, Magnus Damm wrote:
> On Tue, Jan 18, 2011 at 3:39 PM, Raviraj
> <raviraj.bhat@globaledgesoft.com>  wrote:
>    
>> I am observing select time out error whenever shcodecs-record is run 3-4
>> times continuously on ecovec-SH7724.
>>      
> Sounds like a cable problem to me. The Ecovec cables are pretty fragile.
>
> Does mplayer and/or other V4L2 applications behave the same?
>
> / magnus
>
>    
