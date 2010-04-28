From: Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 28 Apr 2010 02:17:05 +0000
Subject: Re: [PATCH 1/2 v2] MMC:Add support MMCIF for SuperH
Message-Id: <20100427221705.1628375b.akpm@linux-foundation.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4BD7C240.5050800@renesas.com>
In-Reply-To: <4BD7C240.5050800@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yusuke Goda <yusuke.goda.sx@renesas.com>
Cc: ben@decadent.org.uk, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org

On Wed, 28 Apr 2010 14:06:08 +0900 Yusuke Goda <yusuke.goda.sx@renesas.com> wrote:

> +	time = wait_event_interruptible_timeout(host->intr_wait,
> +			host->wait_int = 1 ||
> +			host->sd_error = 1, host->timeout);
> +	if (host->wait_int != 1 && (time = 0 || host->sd_error != 0))
> +		return sh_mmcif_error_manage(host);

wait_event_interruptible_timeout() will return early with -ERESTARTSYS
if the calling process gets signalled (eg, ^C was hit).

The driver uses wait_event_interruptible_timeout() rather a lot and the
two sites I looked at seem to handle the signal_pending() case
correctly.

But incorrectly handling signals with interruptible waits is a
frequently-occurring error in drivers.  Did you deliberately cater for
this case, and have you runtime tested it?

