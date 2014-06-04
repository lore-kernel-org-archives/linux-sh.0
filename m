From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 04 Jun 2014 23:00:21 +0000
Subject: Re: [PATCH 1/2] ARM: lager: enable i2c devices
Message-Id: <538FA505.50804@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1392224674-5328-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1392224674-5328-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 02/12/2014 08:04 PM, Ben Dooks wrote:

> Add i2c0, i2c1, i2c2 and i2c3 nodes to the Lager reference device tree as
> these busses all have devices on them that can be probed even if they
> are no drivers yet.

> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

    Hm, these patches seem to be pre-requisites for the Lager VIN patchset.
Why haven't they been merged still?

WBR, Sergei

