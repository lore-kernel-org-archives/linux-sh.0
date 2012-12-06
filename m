From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 06 Dec 2012 14:14:15 +0000
Subject: Re: [PATCH 3/4] spi: sh-msiof: Add device tree parsing to driver
Message-Id: <20121206141415.10BB43E0948@localhost>
List-Id: <linux-sh.vger.kernel.org>
References: <1352288407-20594-1-git-send-email-hechtb@gmail.com>
 <1352288407-20594-4-git-send-email-hechtb@gmail.com>
In-Reply-To: <1352288407-20594-4-git-send-email-hechtb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed,  7 Nov 2012 12:40:06 +0100, Bastian Hecht <hechtb@gmail.com> wrote:
> This adds the capability to retrieve setup data from the device tree
> node. The usage of platform data is still available.
> 
> Signed-off-by: Bastian Hecht <hechtb@gmail.com>

Aside from the binding issues I've pointed out on patch 4, this change
looks fine. I'll wait for an updated patch before committing.

g.

