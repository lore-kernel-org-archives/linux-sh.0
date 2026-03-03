Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05804DA55A
	for <linux-sh@vger.kernel.org>; Tue,  3 Mar 2026 16:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772554993; cv=none; b=DB6qF0VEv2/gjBfboWL5cBh7oiVpNrqaZudeJlNA8b2Le88lBBfaBqipo/6qiudj0+U/fNqHsH1AD/Hf4xPfhXrwzY5iJ5DNdRQM7CEN62L/QqzW1jCJV5zVXhYUHpWIqsqkniV138jYU8dQ6PXKhKnTCPn0SQnXvkJNXZ29t3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772554993; c=relaxed/simple;
	bh=QnDe6CqK7d7iv5p2X8yN4ClZilCQfBmh+Ih5CDsKBrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BwUX2E08XHZqZkyDB6Kux/OWrmwdDoHvltxNpEP/KAjXxJSaCYGR3u72vgfAqUIds0ReKNpTyExcX+id93vOP3V0wrJRzw08mNzN9SlxvFIrGFzXc1bafrTcKBXXZ9Bwyp76cB09OE/NyFAvv+3UwN6bKYNyOe8pzRjvJaRnVm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hdg81eCG; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdg81eCG"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2ba895adfeaso5100752eec.0
        for <linux-sh@vger.kernel.org>; Tue, 03 Mar 2026 08:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772554987; x=1773159787; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=42DkLzycZBouCea5OS9Ta3kLGIhHRc8gf8Jgyx1nJCE=;
        b=hdg81eCGlojV7urUqIv3aXLNN8u38KycLiJWH0Pc7D7u3XlpZLxazhzW9b+a919MGj
         RwBeCf+nYNHswNM4u+0eRNhOgZt+guWVv0akwBYmkWtB6YmlntamMMTzrFSqYJ9UeMfq
         fxOEg0BxT+zQ3hVrbPS57CjDcYTyunIQRyzRjU1ePz4yeeGcOiMRsgkHCpzo/rRGzozC
         KbnGM6xUQV9SnWhnL+uIT4E6Xmpg+BL6Y0kFrVhLiN9A0kKXiIMfvXDglzeATUBIkD7f
         FDasTSS20/plWkAnMmcM/Pa8fVQ4WhnQ3inRpgKFiQc7AT9oAG2FzwkorV3rlkjbfhSC
         TXaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772554987; x=1773159787;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=42DkLzycZBouCea5OS9Ta3kLGIhHRc8gf8Jgyx1nJCE=;
        b=jqzO13o1U216nipWow0O1dsu58Rfb8GwHIRnz3qQeng5ExwLDG1yM48Imxzc6lcU8u
         OfGO10E8QCPqgH9Zp9skAouPVEMIgzrGZWyoEpXSX1oTEk9gs566v5wTHfDVmMHsWw3C
         Z8yRxBhKPIsctdWHJMySEDL7U0SO+3AroWc7zJ0A1+j1BWoY7fdf7ZnJmgpNtEKwZihS
         fwkSXVKxf0TQyNzYFJHRlvYoACKavolktWlYWB2T2D053SjKtgN1MsOWFPT0Sc4Sy6G0
         K9ldKI19W/wB2uUvGcgF+0fviBzX4LE2w/cGc9stQ3f6nxWw4EPqGecIz52w3H+5jFv5
         07AA==
X-Forwarded-Encrypted: i=1; AJvYcCV6FfZwz/7ElirCqR45MBMIAvMdN2kMl6ip+5iwF/cC+df8H4ndWGvqmKWAO7cl3MlZFP1awT7fzQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxpsL1+xRWV85mO2rTS7VU26E7Cc7lIkaBWrZvxecK7ihwprBp3
	nV5YuXdTYFRHGaCi/F/NaqBgHzX7sIWFUWKJAODRljQM7t3TneVy9Bx4
X-Gm-Gg: ATEYQzz6anl9hNzg/LY1e4HJ+zZU9HH+YKM11IzaA4YLLbEd9rHdAKAfznwhsDcil2q
	W0W7jJrpZeIBq6AQhYs17KlfBo4S/scBTWqKVtPn5teWbUB8F/RW8REP6yJcMic31/B+Tg48G2q
	Qy9WdrcGBVB4SNGXw2zSCMAghenMajLmYwABhS3IIPDyHoAU5jrz91PV7cF0oDfLtuKqL5SUtJh
	EcE1BdEGEdpJ4uqEuvsl5dUUGql2FVZCNDa31cGoXffMjlyLf/OgVNyrBGba8QGEYD6mIq+JRRI
	amJkwW1FVrSwXOiCCgHnGWYxGkFhQYraYvaFwj5zYiisoSnj3nr/bqZ2ot26v6+TlVKKp2RdK1y
	13Mx1IPLVINRHpknWPApDe2TUXlrc5z3UBnjf3LG8MR3xESe+8PBctXxy2D2YKLGjUHrcOU1w7M
	v6j21qgMLFkRRNKLiUZSJTxnjGm8xzCdSh12+NDjNjauSj0dw=
X-Received: by 2002:a05:693c:8151:b0:2be:2b16:b99f with SMTP id 5a478bee46e88-2be2b170190mr181320eec.13.1772554986631;
        Tue, 03 Mar 2026 08:23:06 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1cefd7esm14967005eec.9.2026.03.03.08.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 08:23:06 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 3 Mar 2026 08:23:04 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, hanguidong02@gmail.com,
	ysato@users.sourceforge.jp, dalias@libc.org,
	glaubitz@physik.fu-berlin.de, abelvesa@kernel.org, srini@kernel.org,
	s.nawrocki@samsung.com, nuno.sa@analog.com,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-hwmon@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-sh@vger.kernel.org
Subject: Re: [PATCH v2 3/4] hwmon: axi-fan: don't use driver_override as IRQ
 name
Message-ID: <b46c5757-b67d-4949-b8d8-54b799464b5d@roeck-us.net>
References: <20260303115720.48783-1-dakr@kernel.org>
 <20260303115720.48783-4-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260303115720.48783-4-dakr@kernel.org>

On Tue, Mar 03, 2026 at 12:53:20PM +0100, Danilo Krummrich wrote:
> Do not use driver_override as IRQ name, as it is not guaranteed to point
> to a valid string; use NULL instead (which makes the devm IRQ helpers
> use dev_name()).
> 
> Fixes: 8412b410fa5e ("hwmon: Support ADI Fan Control IP")
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> Reviewed-by: Nuno Sá <nuno.sa@analog.com>

Applied.

Thanks,
Guenter
