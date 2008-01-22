From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 22 Jan 2008 09:57:49 +0000
Subject: Re: Re: Hi, all,
Message-Id: <20080122095749.GA8303@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <200801201730.07407.vapier@gentoo.org>
In-Reply-To: <200801201730.07407.vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jan 22, 2008 at 09:34:28AM +0000, Kieran Bingham wrote:
> The SH2/SH2a does not have any support for shared librarys yet. I
> think its something renesas are thinking about but they haven't got to
> yet.
> 
> This was a problem we hit while working on the board too.
> 
Correct, there's no plan to support shared flat. Shared libraries via ELF
FDPIC will be forthcoming, and we'll keep uClibc updated as that work
moves along. That's not to say that shared flat can't be made to work, we
simply have no plans of supporting it. If someone else wants to work on
this, there's no technical reason why we can't support it.
