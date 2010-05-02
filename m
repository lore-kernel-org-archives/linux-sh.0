From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Sun, 02 May 2010 08:16:46 +0000
Subject: Re: Hi guys, does any of you have experience with touchscreen controllers?
Message-Id: <201005021016.46168.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201004222004.38724.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201004222004.38724.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Dale,
for this application I need neccessarly to deliver ASAP, I'm using linux 
2.6.17; so I do not have al lot of stuff present into the newer ones.
I''ll migrate to state of art as soon as I deliver this application and I'll 
start teh new one.
I wrote a simple driver that works pritty much good

Thanks a lot


In data sabato 01 maggio 2010 16:45:03, Dale ha scritto:
: > Fabio Giovagnini wrote:
> > Hi Dale,
> 
> Hi Fabio,
> 
> Sorry for the delay in responding. I was at the ESC conference this week.
> 
> > maybe I need to be more clear about my condition.
> > 1) I connected the ads7843 to general I/O ports because the SPIs
> > available on sh2a7203 have been be used for other functions;
> > 2) My real problem is the following: I wrote an ADS7843 device driver as
> > a button driver of the input subsystem. I configured the ads7843 with INT
> 
> You wrote the driver? I just used the existing one in the 2.6.28.2 kernel.
> 
> > enabled; so when the touch is pressed I have a burst of IRQ. The IRQ
> > handler read the ads7843 and return to the input subsystem the abs values
> > of the touchscreen.
> 
> I seem to recall you need disable the interrupt upon #PENIRQ and allow the
> polling code to do the job of determining the pen up event.
> 
> > The user program open the file /dev/input/event0 and with the select
> > waits for data; what I see is: during all the time I have a finger on the
> > touch only IRQ handler is exeuted and no action is done in the user
> > program. I tried also opening /dev/input/event0 with O_NONBLOCK flag but
> > nothing changes.
> 
> The existing driver uses the event system. The easiest way to see what I
>  did is to unpack a 2.6.28.2 linux tarball and apply the patch I've
>  attached to this post.
> 
> Dale Larson
> Johnson Controls, Inc
> 

-- 
Fabio Giovagnini

Aurion s.r.l.
P.I e C.F.
00885711200
Tel. +39.051.594.78.24
Cell. +39.335.83.50.919
