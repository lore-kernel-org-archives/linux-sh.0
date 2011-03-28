From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 28 Mar 2011 11:05:16 +0000
Subject: Re: [RFC][PATCH] PM / Platform: Remove __weak definitions of runtime
Message-Id: <AANLkTi=JW-xdzE3tCMohVZ1A=2pk2WHD0WrDPU4FNaXA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201103270058.41632.rjw@sisk.pl>
In-Reply-To: <201103270058.41632.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org

On Sun, Mar 27, 2011 at 8:58 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
>
> Remove the __weak definitions of platform bus type runtime PM
> callbacks, make platform_dev_pm_ops point to the generic routines
> as appropriate and allow architectures using platform_dev_pm_ops to
> replace the runtime PM callbacks in that structure with their own
> set.
>
> Convert architectures providing its own definitions of the platform
> runtime PM callbacks to use the new mechanism.
>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Looking good, thanks Rafael. Tested on the sh7372 Mackerel board.

Acked-by: Magnus Damm <damm@opensource.se>
