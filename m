From: Rob Herring <robh@kernel.org>
Date: Mon, 23 May 2016 21:00:20 +0000
Subject: Re: [PATCH v2 05/12] of: add J-Core SPI master bindings
Message-Id: <20160523210020.GA23118@rob-hp-laptop>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1463708766.git.dalias@libc.org>
 <32585cfb27d31e9d5cb399ecc4d8b89f4ec5e2cb.1463708766.git.dalias@libc.org>
In-Reply-To: <32585cfb27d31e9d5cb399ecc4d8b89f4ec5e2cb.1463708766.git.dalias@libc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>

On Fri, May 20, 2016 at 02:53:04AM +0000, Rich Felker wrote:
> Signed-off-by: Rich Felker <dalias@libc.org>
> ---
>  .../devicetree/bindings/spi/jcore,spi.txt          | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/jcore,spi.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/jcore,spi.txt b/Documentation/devicetree/bindings/spi/jcore,spi.txt
> new file mode 100644
> index 0000000..9055e7d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/jcore,spi.txt
> @@ -0,0 +1,23 @@
> +J-Core SPI master
> +
> +Required properties:
> +
> +- compatible: Must be "jcore,spi2".

In general, these all seem a bit generic. You should be able to 
correlate IP versions to compatible strings.

Rob
