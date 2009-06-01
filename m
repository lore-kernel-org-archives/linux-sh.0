From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 01 Jun 2009 04:59:01 +0000
Subject: Re: [PATCH] Fix SCI console output
Message-Id: <20090601045900.GE1122@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4.2.0.58.J.20090601123439.00b52740@router.itonet.co.jp>
In-Reply-To: <4.2.0.58.J.20090601123439.00b52740@router.itonet.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jun 01, 2009 at 12:53:41PM +0900, SUGIOKA Toshinobu wrote:
> Fix SCI transmission sequence in console output function.
> 
> Signed-off-by: Toshinobu Sugioka <sugioka@itonet.co.jp>
> 
This change was intentional. Do you have a use case where this causes a
problem?
