From: Rob Herring <robh@kernel.org>
Date: Tue, 31 Mar 2020 21:28:57 +0000
Subject: Re: [PATCH v2] dt-bindings: serial: sh-sci: Convert to json-schema
Message-Id: <20200331212857.GA27690@bogus>
List-Id: <linux-sh.vger.kernel.org>
References: <20200325095721.11946-1-geert+renesas@glider.be>
In-Reply-To: <20200325095721.11946-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ulrich Hecht <uli+renesas@fpond.eu>, Chris Brandt <chris.brandt@renesas.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp

On Wed, 25 Mar 2020 10:57:21 +0100, Geert Uytterhoeven wrote:
> Convert the Renesas Serial Communication Interface ((H)SCI(F)(A|B))
> Device Tree binding documentation to json-schema.
> 
> Split the bindings in 5 files, one per major type, to ease expressing
> constraints.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - Drop paragraph about aliases,
>   - Fix power-domains and resets to maxItems 1,
>   - Use a single const compatible value for SCI,
>   - Use lists of descriptions and const values for interrupts resp.
>     interrupt-names for SCI and SCIF,
>   - Use multiple possible lists of descriptions and const values for
>     interrupts resp. interrupt-names for SCIF.
> ---
>  .../bindings/serial/renesas,hscif.yaml        | 135 ++++++++++++++
>  .../bindings/serial/renesas,sci-serial.txt    | 150 ---------------
>  .../bindings/serial/renesas,sci.yaml          |  69 +++++++
>  .../bindings/serial/renesas,scif.yaml         | 172 ++++++++++++++++++
>  .../bindings/serial/renesas,scifa.yaml        | 107 +++++++++++
>  .../bindings/serial/renesas,scifb.yaml        |  98 ++++++++++
>  6 files changed, 581 insertions(+), 150 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/serial/renesas,hscif.yaml
>  delete mode 100644 Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
>  create mode 100644 Documentation/devicetree/bindings/serial/renesas,sci.yaml
>  create mode 100644 Documentation/devicetree/bindings/serial/renesas,scif.yaml
>  create mode 100644 Documentation/devicetree/bindings/serial/renesas,scifa.yaml
>  create mode 100644 Documentation/devicetree/bindings/serial/renesas,scifb.yaml
> 

Applied, thanks.

Rob
