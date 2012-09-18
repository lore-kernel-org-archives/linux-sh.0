From: Simon Horman <horms@verge.net.au>
Date: Tue, 18 Sep 2012 01:37:30 +0000
Subject: Re: [PATCH 0/2] ARM; shmobile: kzm9g: enable sensors on the board
Message-Id: <20120918013730.GE28305@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1347614069-23345-1-git-send-email-koba@kmckk.co.jp>
In-Reply-To: <1347614069-23345-1-git-send-email-koba@kmckk.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Sep 14, 2012 at 06:14:27PM +0900, Tetsuyuki Kobayashi wrote:
> Hello, simon-san
> 
> KZM-A9-GT board (kzm9g) has 2 sensor chip on the board.
>  - magnetometer AK8975
>  - three-axis digital accelerometer ADXL345
> This patch registers device driver and assign I2C slave address and IRQ.
> 
> Tetsuyuki Kobayashi (2):
>   ARM: shmobile: kzm9g: enable magnetometer ak8975.
>   ARM: shmobile: kzm9g: enable three-axis digital accelerometer ADXL345

Thanks I have applied these changes to the boards branch,
I will now send them to linux-arm-kernel@lists.infradead.org for review
