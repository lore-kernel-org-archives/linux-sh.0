From: "Adrian McMenamin" <adrian@newgolddream.dyndns.info>
Date: Wed, 23 Jan 2008 09:29:47 +0000
Subject: Re: debian etch sh3 and sh4
Message-Id: <32741.85.118.17.158.1201080587.squirrel@newgolddream.dyndns.info>
List-Id: <linux-sh.vger.kernel.org>
References: <82C85C285793D5ebiharaml@si-linux.com>
In-Reply-To: <82C85C285793D5ebiharaml@si-linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, January 22, 2008 10:49 pm, Mike Frysinger wrote:
> On Tuesday 22 January 2008, Adrian McMenamin wrote:
>> On Tue, January 22, 2008 2:34 pm, Mike Frysinger wrote:
>> > err, 18 months ?  which stages are you looking at ?
>>
>> I was looking at the uclibc stuff, which I admit is not a strictly fair
>> comparison (as the Debian stuff is linked with glibc)
>
> i can look at refreshing the uClibc stages this time around ... when i was
> doing 2007.0, i didnt have enough time to bounce glibc and uclibc at the
> sametime


How good is emerge when memory is in short supply in the glibc versions?
apt/dpkg is a pig - takes forever and then OOMs :(

(But I am still trying to get the alsa stuff installed that way so I can
finally see if it is my driver or my setup that is at fault)

The alternative might be to try the dreaded swap-over-nfs but that didn't
work last time I tried it (a few years ago now)

