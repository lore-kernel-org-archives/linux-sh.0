From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Thu, 03 Dec 2009 13:08:14 +0000
Subject: Re: [PATCH] sh: allow runtime pm without suspend/resume callbacks
Message-Id: <20091203130814.GA31533@rakim.wolfsonmicro.main>
List-Id: <linux-sh.vger.kernel.org>
References: <20091203123145.9997.81575.sendpatchset@rxone.opensource.se>
In-Reply-To: <20091203123145.9997.81575.sendpatchset@rxone.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Dec 03, 2009 at 09:31:45PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> This patch updates the Runtime PM code for SuperH Mobile
> to allow drivers to have NULL as pm or callback value.
> With this in place there is no need for no-op functions.

Thanks for doing this.
