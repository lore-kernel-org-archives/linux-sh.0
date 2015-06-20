From: Rob Landley <rob@landley.net>
Date: Sat, 20 Jun 2015 19:59:38 +0000
Subject: Re: [musl] Re: SH sigcontext ABI is broken
Message-Id: <5585C62A.5060301@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20150619070912.GA15025@brightrain.aerifal.cx>
In-Reply-To: <20150619070912.GA15025@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 06/20/2015 03:10 AM, Geert Uytterhoeven wrote:
> On Fri, Jun 19, 2015 at 10:32 PM, Rich Felker <dalias@libc.org> wrote:
>> On Fri, Jun 19, 2015 at 09:57:22PM +0200, Andreas Schwab wrote:
>>> Rich Felker <dalias@libc.org> writes:
>>>
>>>> Thanks, but most of the links seem to be broken.
>>>
>>> Are they?  I'm only seeing a single broken link, which has a mirror.
>>
>> My bad. Indeed only the davej one is broken, but that's where the code
>> must have been introduced (even the earliest commit in tglx
>> history.git has the #ifdef __SH4__ for FPU regs) and I can't find a
>> cgit interface to it. Fetching several GB to browse history locally is
>> going to take a while if I have to do that..
> 
> Using web interfaces for archeology doesn't fly.
> If you're doing serious Linux work, you should already have a git repository
> of the kernel. full-history-linux.git.tar weights in at only ca. 0.5 giB.

I have a somewhat updated version of that at
http://landley.net/kdocs/local/linux-fullhist.tar.bz2 which I should
probably update for the 4.0 release. (It's pulled to 3.0 currently.)

Meanwhile you can download and extract that tarball, cd into it, then
"git checkout -f" followed by "git pull". (It doesn't have the checked
out files because it would make the tarball bigger, it's just the .git
directory.) That gives you a repository that goes from 0.0.1 to current,
although I haven't gone back and tagged the old releases yet.

Oh, you may want to edit .git/config so it pulls from linux instead of
linux-2.6. Largely cosmetic, but eh...

> Gr{oetje,eeting}s,
> 
>                         Geert

Rob
--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
