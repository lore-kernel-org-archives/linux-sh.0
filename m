From: Kevin Hilman <khilman@ti.com>
Date: Fri, 24 Jun 2011 18:25:26 +0000
Subject: Re: [PATCH] PM / Runtime: Update documentation of interactions with system sleep
Message-Id: <87sjqz13zd.fsf@ti.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201106112223.04972.rjw@sisk.pl> <871uyljys6.fsf@ti.com>
	<201106230022.56462.rjw@sisk.pl> <201106231557.43653.rjw@sisk.pl>
In-Reply-To: <201106231557.43653.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Thu, 23 Jun 2011 15:57:43 +0200")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, Magnus Damm <magnus.damm@gmail.com>, Paul Walmsley <paul@pwsan.com>, Alan Stern <stern@rowland.harvard.edu>, LKML <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> From: Rafael J. Wysocki <rjw@sisk.pl>
>
> The documents describing the interactions between runtime PM and
> system sleep generally refer to the model in which the system sleep
> state is entered through a global firmware or hardware operation.
> As a result, some recommendations given in there are not entirely
> suitable for systems in which this is not the case.  Update the
> documentation take the existence of those systems into accout.
>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Looks good, thanks for updating this.

Reviewed-by: Kevin Hilman <khilman@ti.com>

Kevin
