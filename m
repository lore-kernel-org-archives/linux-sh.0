From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 24 Jun 2008 04:01:28 +0000
Subject: Re: [PATCH] maple: tidy  maple_driver code by removing redundant connect/disconnect
Message-Id: <20080624040128.GB22526@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1213559289.22707.15.camel@localhost.localdomain>
In-Reply-To: <1213559289.22707.15.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-sh <linux-sh@vger.kernel.org>

On Sun, Jun 15, 2008 at 08:48:09PM +0100, Adrian McMenamin wrote:
> The connect and disconnect functions are unnecessary - everything they do can be
> accomplished in the initial probe - so remove them.
> 
> Signed-off-by: Adrian McMenamin <adrian@mcmen.demon.co.uk>

Applied, thanks.
