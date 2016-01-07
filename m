From: Rob Herring <robh@kernel.org>
Date: Thu, 07 Jan 2016 23:00:12 +0000
Subject: Re: [PATCH 1/2] dt-bindings: move I2C eeprom descriptions to the proper file
Message-Id: <20160107230012.GA15023@rob-hp-laptop>
List-Id: <linux-sh.vger.kernel.org>
References: <1452199860-3601-1-git-send-email-wsa@the-dreams.de>
 <1452199860-3601-2-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1452199860-3601-2-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Simon Horman <horms@verge.net.au>, linux-kernel@vger.kernel.org

On Thu, Jan 07, 2016 at 09:50:59PM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> EEPROMs can have additional properties, so they are not suitable for
> trivial-devices.txt. Move most bindings to the designated eeprom.txt.
> Add the missing "atmel,24c08" while doing that. Note that the remaining
> ones in trivial-devices need to be dealt with seperately because of

s/seperately/separately/

> improper manufacturer names.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  Documentation/devicetree/bindings/eeprom/eeprom.txt   | 19 ++++++++++++++-----
>  .../devicetree/bindings/i2c/trivial-devices.txt       | 13 -------------
>  2 files changed, 14 insertions(+), 18 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>

Fine to take these thru your tree.

Rob
