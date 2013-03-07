From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 07 Mar 2013 05:51:58 +0000
Subject: Re: [PATCH v6 1/3] serial: sh-sci: Add OF support
Message-Id: <201303070551.59191.arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1362569437-11133-1-git-send-email-hechtb+renesas@gmail.com>
 <2479902.R2JaqaE7dT@avalon> <20130306152857.GJ14275@linux-sh.org>
In-Reply-To: <20130306152857.GJ14275@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wednesday 06 March 2013, Paul Mundt wrote:
> Now that we have split things out in to regtype for the compat string we
> may be able to get away with selecting defaults that match the regtype
> and drop it from the binding (assuming all future parts remain relatively
> sane), but it would still complicate things if we were to ever do DT
> support for legacy CPUs. It's not enough to tie to the port type, as
> there are plenty of cases where the port type uses a non-standard algo on
> some CPU subtypes (although things are pretty consistent for the arm side
> so far).

Maybe we could document it as an optional property that we may use for the
legacy CPUs if necessary, but put it into the ARM dts files or into
the driver implementation for the time being.

	Arnd
