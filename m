From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 17 Jun 2014 15:24:34 +0000
Subject: Re: [PATCH 2/8] r8a66597-udc: keep dev as reference to &pdev->dev
Message-Id: <53A05DB2.9070803@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1403018101-11062-3-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1403018101-11062-3-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

hello.

On 06/17/2014 07:14 PM, Ben Dooks wrote:

> Remove usages of &pdev->dev in the driver probe function

    s/Remove/Replace/?

> with just dev to make the references to it easier to
> write. Convert all the current users of it to use it.

> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

WBR, Sergei


