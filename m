From: Simon Horman <horms@verge.net.au>
Date: Wed, 11 Mar 2015 00:01:56 +0000
Subject: Re: Can't boot kernel v4.0-rc2 on Koelsch
Message-Id: <20150311000150.GA6958@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <2263226.JPOqZgiCRj@avalon>
In-Reply-To: <2263226.JPOqZgiCRj@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

On Tue, Mar 10, 2015 at 12:32:59PM +0100, Geert Uytterhoeven wrote:
> Hi Hiep-san,
> 
> On Tue, Mar 10, 2015 at 10:03 AM, Cao Minh Hiep <cm-hiep@jinso.co.jp> wrote:
> > On 2015年03月10日 17:05, Nobuhiro Iwamatsu wrote:
> >> This is user land issue.
> >> Hiep, if you have not changed ttySCX in inittab, you will need to change.
> >> Could you check your inittab?
> >>
> >> --- a/inittab    2015-03-10 15:01:58.986609389 +0900
> >> +++ b/inittab    2015-03-10 15:00:32.132094877 +0900
> >> @@ -28,7 +28,7 @@
> >>   l6:6:wait:/etc/init.d/rc 6
> >>   # Normally not reached, but fallthrough in case of emergency.
> >>   z6:6:respawn:/sbin/sulogin
> >> -SC6:12345:respawn:/sbin/getty -L 38400 ttySC6
> >> +SC0:12345:respawn:/sbin/getty -L 38400 ttySC0
> >>   # /sbin/getty invocations for the runlevels.
> >>   #
> >>   # The "id" field MUST be the same as the last
> >
> > There is no inittab file in Linaro userland that I am using.
> 
> I'm not familiar with the Linaro userland.
> 
> Is there any other configuration file that contains the string "ttySC6"?
> Or does the Linaro userland derive it from the kernel command line?
> If yes, perhaps there's a newer version that does look at stdout-path instead?
> 
> The goal of the stdout-path support was to have a better description in DT
> and automate things. So I don't think reverting the change is the proper way
> forward.
> 
> If you can't get it to work, I think we should bring it up with the DT people
> first, some of which work for Linaro.

I am inclined to agree with with Geert on this issue.
