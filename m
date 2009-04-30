From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 30 Apr 2009 07:19:55 +0000
Subject: Re: Fw: [Linux-openweb] About linux on Compaq Aero 8000.
Message-Id: <20090430071955.GB13449@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <A52DA1107FA5413882548F4E686101AD@atytan>
In-Reply-To: <A52DA1107FA5413882548F4E686101AD@atytan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Apr 30, 2009 at 09:16:43AM +0200, jdsoul wrote:
> >On Wed, 29 Apr 2009 08:56:09 +0200
> >jdsoul <jdsoul@wp.pl> wrote:
> >
> >>Is there any possibility to remove old Wince CE Handheld from Compaq Aero 
> >>8000 (SH4 128MHz mashine)
> >>and put any Linux system on it???

You might still find some old kernel images floating around to support
this device, but nothing has happened on this port since the 2000/2001
period, and it was purged from the kernel years ago. Philipp Rumpf
(prumpf@tux.org) did the reverse engineering and porting to that
particular platform, so you may try to get in contact with him to see if
he has any suggestions for you.

Of course if you are interested in doing the leg work for porting the old
support code to a current kernel and looking after the port, we can of
course consider re-adding support for the platform.
