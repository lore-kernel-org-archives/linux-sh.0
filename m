Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792653401;
	b=cLQhAb59cTiJGTHEZCqZjPhQA+8WM8O8FyqWRsuvAu0XwsP6ZA1QlmZ07ot9OWGs6v2s
	 GnDuV8Mm8x+UEHpL4IFUkFxUKPQBt2OPX/0Xz2ipXMMgvPdFoIUYtc/G8zaU7LHhsJEc9
	 1CXbaY1IiS3azfRsfZXk2sDNXAOF5qWb88zVkh8sx/MtWtExFBhz/Z2tVDBI3ML0ZZU0r
	 dcZcUuQyhBykApvd407u/GezQQ071F32cOohtKNn1MeKL9Lz8CouhaJPDqh9NS+wGINBb
	 3SufwbyvjppFN7WXj+UTdL9TCUrDcIX8SMgY5uHUWc+m9isYibOeWBANxUkK01s6etg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792653401;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=CJUX6eo6JLhVWx/UAGNADhBQZV1PO1Apn3qJBScevp4=;
	b=R0T7cEexLvR1F0Zt7cSkduNH1OYtCNPqBqnlofF+vgESglsooGuoJTaSHFO1miguW/jS
	 NgRIuX/cs5jzjL3LoeMzTRF1GpK8XQgOI4yK8NMclt1z6+A1VA49jyokZHZ4GHjdzqP07
	 wJAqMWsg/xGYrs+ApqcuAE3P98qkJJxzmzevxKpsyCS/ebzBt7iZeSOwy/6dBFpJzf1gp
	 cVogYFuOZTTKzLHLrHZOpBHKkmsc0BRYRqBiaVdtgag+q/vHJdtgX8ZLJGES4vFmUoouB
	 2Rp4AFc+wOI6P4e6UYt/qr4RQx43BuIZNrJJPctlzDVmA7/pkDK9EhJ4N1LzDmvI/qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fVkpZKAy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE031606A319;
	Thu, 22 Oct 2026 07:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fVkpZKAy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD251F000C1;
	Thu, 22 Oct 2026 07:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792653400;
	bh=CJUX6eo6JLhVWx/UAGNADhBQZV1PO1Apn3qJBScevp4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fVkpZKAyiBWURNQcG3wCGYODk4tAQJ5qC+rjQn8SHsxbMEf2XPjDXE4umR40HNFga
	 qe3ZG7hcsVVBTCG48Uxyi8q2BUsYjmbx9q44/8VoixgOLoZ3gaWZieQVLOeZOFWRVZ
	 kU44y2oMpjPkTOFDnpGV9Rnbmp0zo5F/qZSIrmOR30WZr3w0OwOQbpEZALi2OXtXTS
	 0dn9NeEPBjUQ8eEqT5JYyAZ42DYXHTfZjOWyc9FQQc/1GBMG3PAX2Y9TTZIz3pAHbK
	 UDffOqkhxgbCsQ9K6ZTNCWkDdIAOfOX6OSAWdAi3JygxTSmMixtEkYqeIgky1NFxFR
	 nqV26dd3DvyJA==
Message-ID: <d6562416-05aa-452d-8fe5-a68cb8f50f01@kernel.org>
Date: Thu, 22 Oct 2026 09:16:35 +0200
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: soc: document Casio fx-9750GIII
To: Artem Novak <artem122novak@gmail.com>, robh@kernel.org
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de
References: <20261022063902.471383-1-artem122novak@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20261022063902.471383-1-artem122novak@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/10/2026 08:39, Artem Novak wrote:
> Document for the Casio fx-9750GIII graphing calculator,
> which is based on the Renesas SH7305 (SH4A) processor.
> 
> Add the Casio vendor prefix and the board compatible
> binding.

This looks oddly wrapped.

Please wrap commit message according to Linux coding style / submission
process (neither too early nor over the limit):
https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597

Anyway, I do not understand why this is sent separately from any other
code. We do not take usually bindings without any users.

> 
> Signed-off-by: Artem Novak <artem122novak@gmail.com>
> ---
>  .../soc/renesas/casio,fx-9750giii.yaml        | 33 +++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |  2 ++
>  2 files changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/renesas/casio,fx-9750giii.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/renesas/casio,fx-9750giii.yaml b/Documentation/devicetree/bindings/soc/renesas/casio,fx-9750giii.yaml
> new file mode 100644
> index 000000000000..f3c1c02f1bd5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/renesas/casio,fx-9750giii.yaml
> @@ -0,0 +1,33 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/renesas/casio,fx-9750giii.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Casio fx-9750GIII Graphing Calculator
> +
> +maintainers:
> +  - Artem Novak <artem122novak@gmail.com>
> +
> +description:
> +  The Casio fx-9750GIII graphing calculator is based on
> +  the Renesas SH7305 processor.
> +
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        const: casio,fx-9750giii
> +  required:
> +    - compatible

And this I do not understand at all. Why do you need this?

> +
> +properties:
> +  compatible:
> +    items:
> +      - const: casio,fx-9750giii
> +      - const: renesas,sh7305

Where is any user of this?


Best regards,
Krzysztof
