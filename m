From: "Adrian McMenamin" <adrian@newgolddream.dyndns.info>
Date: Wed, 23 Jan 2008 10:28:54 +0000
Subject: Re: debian etch sh3 and sh4
Message-Id: <60177.85.118.17.158.1201084134.squirrel@newgolddream.dyndns.info>
List-Id: <linux-sh.vger.kernel.org>
References: <82C85C285793D5ebiharaml@si-linux.com>
In-Reply-To: <82C85C285793D5ebiharaml@si-linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, January 23, 2008 9:53 am, Paul Mundt wrote:
> In 16MB you will always be bordering on thrashing just trying to do _any_
> basic tasks. Your options are realistically limited to busybox or
> throwing the damn thing out (the recommended option). Doing anything more
> involved than that was pretty questionable back when the kernel used a
> lot less memory, and trying to do builds in that environment is well past
> absurdity these days. 64MB is painful, but at least workable.
>
You really are like the Kerryman who, when asked how to get to Dublin said
"well, I wouldn't start from here." :)

I don't mind the thrashing if it gets me something that works and which
can later be used as the basis of a "distro" - which is my aim here.

Anyone know how stable swap over nfs is these days? Speed is a secondary
consideration.

NB: CF or similar isn't an option. In theory you could put a very small
swap partition on the Dreamcast's VMUs but access to that is likely to be
much slower even than NFS - as it would be rationed to 60 times per
second.

