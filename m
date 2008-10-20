From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 20 Oct 2008 02:28:32 +0000
Subject: Re: [PATCH] sh64: rescue get_user/put_user
Message-Id: <20081020022832.GA19416@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20081019192929.GA22064@x200.localdomain>
In-Reply-To: <20081019192929.GA22064@x200.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Oct 19, 2008 at 11:29:29PM +0400, Alexey Dobriyan wrote:
> 	(void *)&__pu_val, __pu_addr
> 
> is what original include/asm-sh64/uaccess.h did.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

This is already fixed in my queue, but thanks anyways!
