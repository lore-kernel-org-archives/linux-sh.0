From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Date: Thu, 07 Feb 2008 13:24:55 +0000
Subject: Re: HP6xx : weird hwclock behavior, bug?
Message-Id: <20080207142455.dbb94e8a.Kristoffer.ericson@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20080207002825.96bfbf6b.Kristoffer.ericson@gmail.com>
In-Reply-To: <20080207002825.96bfbf6b.Kristoffer.ericson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, 7 Feb 2008 11:16:07 +0900
Paul Mundt <lethal@linux-sh.org> wrote:

> On Thu, Feb 07, 2008 at 12:28:25AM +0100, Kristoffer Ericson wrote:
> > hwclock --show = works
> > hwclock --systohc = freezes system
> > 
> > Its hard to say wether it ever worked since we haven't used the rtc much.
> > 
> It works fine on all of the SH-4 systems, but I don't know if anyone has
> done any SH-3 testing with rtc-sh.

Oki, any good way to test this? fill the rtc driver with printk's?
