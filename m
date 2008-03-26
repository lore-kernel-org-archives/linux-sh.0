From: Mark Brown <broonie@sirena.org.uk>
Date: Wed, 26 Mar 2008 11:29:44 +0000
Subject: Re: [PATCH] Touch screen driver for the SuperH MigoR board
Message-Id: <20080326112943.GA26346@sirena.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <20080321111630.13138.14500.sendpatchset@rx1.opensource.se> <20080321155515.bb9f945e.akpm@linux-foundation.org> <aec7e5c30803252103x1534e43dv3f31a3bc731fc9bf@mail.gmail.com>
In-Reply-To: <aec7e5c30803252103x1534e43dv3f31a3bc731fc9bf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, lethal@linux-sh.org, dmitry.torokhov@gmail.com, linux-sh@vger.kernel.org

On Wed, Mar 26, 2008 at 01:03:09PM +0900, Magnus Damm wrote:

> interrupt and handle everything from a different context. Apart from
> avoiding serious latency issues, doing things from interrupt context
> simply won't work since the i2c bus driver may be interrupt driven and
> may sleep while waiting for the serial bus data to be sent.

Given that having devices that generate interrupts that need to be
serviced over interrupt driven buses is a fairly common pattern it seems
like it would be worth adding some helper code - if nothing else, it
would help with the documentation.

-- 
"You grabbed my hand and we fell into it, like a daydream - or a fever."
