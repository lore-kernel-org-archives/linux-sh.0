From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 05 Sep 2011 03:23:53 +0000
Subject: Re: [PATCH] [RFC] sh: kexec: Register crashk_res
Message-Id: <20110905032352.GA22142@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1314935232-1545-1-git-send-email-horms@verge.net.au>
In-Reply-To: <1314935232-1545-1-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Sep 02, 2011 at 12:47:12PM +0900, Simon Horman wrote:
> Register crashk_res so that it can be used by kexec-tools
> via /proc/iomem.
> 
> On x86 the registration occurs using
> insert_resource(&iomem_resource, &crashk_res).
> However that approach seems to result in the boot hanging on SH.
> 
> Signed-off-by: Simon Horman <horms@verge.net.au>

x86 has a slightly more straightforward registration method. We end up
going through the same path for all memory ranges, which also
encapsulates the NUMA case. As such, we don't necessarily know which
range will contain the resource in question, so it's attempted on each
range addition, expecting the resource manager to work things out for us.

With the request_resource() in place you presumably see the crash kernel
resource where you expect it to in /proc/iomem?
