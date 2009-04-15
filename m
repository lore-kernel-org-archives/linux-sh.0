From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 15 Apr 2009 11:15:12 +0000
Subject: Re: [PATCH][RFC] sh: suspend interpreter V1
Message-Id: <aec7e5c30904150415o2a0fdf87ta50c0644b11cd95b@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20090323091739.25647.6773.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090323091739.25647.6773.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Mar 31, 2009 at 5:42 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> We need to see hard requirements here, in technical detail, not
> hand-waving about needing to be flexible for parts and requirements that
> never materialize. Assembly stubs do work for the vast majority of cases
> we have today, and the current model fits the CPU/board split pretty
> well.

Yes, assembly stubs work fine for the SuperH Mobile sleep modes
implemented so far. I suspect that upcoming "R-standby mode" will be
easier to support with an interpreter though. Time will tell.

Francesco, if you feel like it and have time available, please
consider submitting support for some ST cpu/board combination
upstream. That may make it easier to motivate why an interpreter is
needed.

Cheers,

/ magnus
