From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 18 May 2010 11:17:28 +0000
Subject: Re: [GIT PULL] sh updates for 2.6.35-rc1
Message-Id: <AANLkTikPCCF3CDxozbPgiRFy2s5OX19oVrApsKhLnwqt@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20100518092532.GA3050@linux-sh.org>
	 <AANLkTim6t8oG-vdLKE918Sd2TFKJpSf5Bw2PTtSsD_Fh@mail.gmail.com>
	 <20100518101500.GA3156@linux-sh.org>
	 <AANLkTinIVjwrQ9gza2FIvZN5w4nm8ZjSUe836oRmWYG7@mail.gmail.com>
	 <AANLkTindMQ3Clk_qVnwUNYbbWcXjsUyyy4fQsjdDflFt@mail.gmail.com>
	 <AANLkTilNQwo1YYT2pNJN5X0ae98iMKCdsBkcogjKZm-f@mail.gmail.com>
In-Reply-To: <AANLkTilNQwo1YYT2pNJN5X0ae98iMKCdsBkcogjKZm-f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jaswinder Singh Rajput <jaswinderlinux@gmail.com>
Cc: Paul Mundt <lethal@linux-sh.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>

Hi Jaswinder,

On Tue, May 18, 2010 at 8:16 PM, Jaswinder Singh Rajput
<jaswinderlinux@gmail.com> wrote:
> I am looking at the future, where multiple architecture will use each
> other files.
>
> I am just worried about the file count. Currently :
>
> $ ls include/linux/ | wc -l
> 1029
>
> If other architecture will also start adding the files in
> include/linux like you did then ?
>
> So better make another directory in include.

Perhaps we can deal with that whenever it becomes an issue.

Thank you.

/ magnus
